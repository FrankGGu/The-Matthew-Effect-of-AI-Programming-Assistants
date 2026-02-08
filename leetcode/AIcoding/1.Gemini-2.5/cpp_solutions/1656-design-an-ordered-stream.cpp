#include <vector>
#include <string>

class OrderedStream {
private:
    std::vector<std::string> data;
    int ptr;
    int max_n;

public:
    OrderedStream(int n) {
        data.resize(n + 1, "");
        ptr = 1;
        max_n = n;
    }

    std::vector<std::string> insert(int idKey, std::string value) {
        data[idKey] = value;

        std::vector<std::string> result;
        while (ptr <= max_n && !data[ptr].empty()) {
            result.push_back(data[ptr]);
            ptr++;
        }

        return result;
    }
};