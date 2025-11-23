class Solution {
public:
    string reorganizeString(string s) {
        unordered_map<char, int> freq;
        for (char c : s) {
            freq[c]++;
        }

        priority_queue<pair<int, char>> maxHeap;
        for (auto& [ch, count] : freq) {
            maxHeap.push({count, ch});
        }

        string res;
        while (maxHeap.size() >= 2) {
            auto [count1, ch1] = maxHeap.top(); maxHeap.pop();
            auto [count2, ch2] = maxHeap.top(); maxHeap.pop();

            res += ch1;
            res += ch2;

            if (--count1 > 0) maxHeap.push({count1, ch1});
            if (--count2 > 0) maxHeap.push({count2, ch2});
        }

        if (!maxHeap.empty()) {
            auto [count, ch] = maxHeap.top();
            if (count > 1) return "";
            res += ch;
        }

        return res;
    }
};