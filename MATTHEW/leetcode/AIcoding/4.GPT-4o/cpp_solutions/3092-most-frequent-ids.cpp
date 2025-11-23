#include <vector>
#include <unordered_map>
#include <algorithm>

std::vector<int> mostFrequent(std::vector<int>& ids) {
    std::unordered_map<int, int> freq;
    for (int id : ids) {
        freq[id]++;
    }

    int maxFreq = 0;
    for (const auto& pair : freq) {
        maxFreq = std::max(maxFreq, pair.second);
    }

    std::vector<int> result;
    for (const auto& pair : freq) {
        if (pair.second == maxFreq) {
            result.push_back(pair.first);
        }
    }

    std::sort(result.begin(), result.end());
    return result;
}