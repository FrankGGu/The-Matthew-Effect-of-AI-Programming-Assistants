class Solution {
public:
    vector<string> subdomainVisits(vector<string>& cpdomains) {
        std::map<std::string, int> counts;

        for (const std::string& cpdomain : cpdomains) {
            size_t space_pos = cpdomain.find(' ');
            int count = std::stoi(cpdomain.substr(0, space_pos));
            std::string domain = cpdomain.substr(space_pos + 1);

            counts[domain] += count;

            size_t dot_pos = domain.find('.');
            while (dot_pos != std::string::npos) {
                domain = domain.substr(dot_pos + 1);
                counts[domain] += count;
                dot_pos = domain.find('.');
            }
        }

        std::vector<std::string> result;
        for (const auto& pair : counts) {
            result.push_back(std::to_string(pair.second) + " " + pair.first);
        }

        return result;
    }
};