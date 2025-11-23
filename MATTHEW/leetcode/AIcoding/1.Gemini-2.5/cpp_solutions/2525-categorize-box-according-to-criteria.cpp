class Solution {
public:
    string categorizeBox(int length, int width, int height, int mass) {
        long long volume = 1LL * length * width * height;

        bool isBulky = false;
        if (length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000LL) {
            isBulky = true;
        }

        bool isHeavy = false;
        if (mass >= 100) {
            isHeavy = true;
        }

        if (isBulky && isHeavy) {
            return "Both";
        } else if (isBulky) {
            return "Bulky";
        } else if (isHeavy) {
            return "Heavy";
        } else {
            return "Neither";
        }
    }
};