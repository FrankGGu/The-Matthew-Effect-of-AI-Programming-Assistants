#include <string>
#include <vector>
#include <unordered_map>

using namespace std;

class MapSum {
public:
    MapSum() {}

    void insert(string key, int val) {
        dict[key] = val;
    }

    int sum(string prefix) {
        int res = 0;
        for (auto const& [key, value] : dict) {
            if (key.rfind(prefix, 0) == 0) {
                res += value;
            }
        }
        return res;
    }

private:
    unordered_map<string, int> dict;
};