class Solution {
public:
    bool hasGroupsSizeX(vector<int>& deck) {
        unordered_map<int, int> count;
        for (int card : deck) {
            count[card]++;
        }
        int g = -1;
        for (const auto& pair : count) {
            if (g == -1) {
                g = pair.second;
            } else {
                g = gcd(g, pair.second);
            }
        }
        return g >= 2;
    }

private:
    int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
};