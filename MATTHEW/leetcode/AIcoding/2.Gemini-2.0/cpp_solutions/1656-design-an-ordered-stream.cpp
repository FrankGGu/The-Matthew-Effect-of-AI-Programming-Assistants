#include <vector>
#include <string>

class OrderedStream {
public:
    OrderedStream(int n) : stream(n + 1, "") {
        ptr = 1;
    }

    std::vector<std::string> insert(int idKey, std::string value) {
        stream[idKey] = value;
        std::vector<std::string> result;
        while (ptr < stream.size() && stream[ptr] != "") {
            result.push_back(stream[ptr]);
            ptr++;
        }
        return result;
    }

private:
    std::vector<std::string> stream;
    int ptr;
};