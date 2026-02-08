class Solution {
public:
    int getMaxRepetitions(string s1, int n1, string s2, int n2) {
        int count = 0, index = 0;
        unordered_map<int, pair<int, int>> seen;

        while (count < n1) {
            for (char c : s1) {
                if (c == s2[index]) {
                    index++;
                    if (index == s2.size()) {
                        count++;
                        index = 0;
                    }
                }
            }
            if (seen.count(index)) {
                auto [prevCount, prevTotal] = seen[index];
                int cycleCount = (n1 - count) / (count - prevCount);
                count += cycleCount * (count - prevCount);
                index += cycleCount * (prevTotal - prevCount);
                break;
            }
            seen[index] = {count, index};
            count++;
        }

        return count / n2;
    }
};