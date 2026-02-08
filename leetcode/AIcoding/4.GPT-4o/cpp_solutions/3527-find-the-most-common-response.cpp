#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

string mostCommonResponse(vector<string>& responses) {
    unordered_map<string, int> count;
    for (const auto& response : responses) {
        count[response]++;
    }

    string most_common;
    int max_count = 0;

    for (const auto& pair : count) {
        if (pair.second > max_count) {
            max_count = pair.second;
            most_common = pair.first;
        } else if (pair.second == max_count) {
            most_common = min(most_common, pair.first);
        }
    }

    return most_common;
}