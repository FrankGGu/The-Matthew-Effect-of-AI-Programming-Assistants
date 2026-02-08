#include <vector>
#include <unordered_map>
#include <queue>
using namespace std;

vector<int> topKStudents(vector<vector<int>>& score, int K) {
    unordered_map<int, int> studentScores;
    for (const auto& s : score) {
        studentScores[s[0]] += s[1];
    }

    priority_queue<pair<int, int>> pq;
    for (const auto& entry : studentScores) {
        pq.push({entry.second, entry.first});
    }

    vector<int> result;
    for (int i = 0; i < K; ++i) {
        result.push_back(pq.top().second);
        pq.pop();
    }

    return result;
}