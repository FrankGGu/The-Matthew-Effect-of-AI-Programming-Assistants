class Solution {
public:
    vector<string> splitMessage(string message, int limit) {
        vector<string> result;
        int n = message.size();
        int totalLength = 0;
        int part = 1;

        while (true) {
            int currentLength = to_string(part).size() + 2; // for "[]"
            if (part > 1) currentLength += 1; // for space before the next part
            if (totalLength + currentLength + n > limit * part) {
                break;
            }
            result.push_back(message.substr(totalLength, limit * part - totalLength - currentLength) + " [" + to_string(part) + "]");
            totalLength += limit * part - currentLength;
            part++;
        }

        if (totalLength < n) {
            result.push_back(message.substr(totalLength) + " [" + to_string(part) + "]");
        }

        return result;
    }
};