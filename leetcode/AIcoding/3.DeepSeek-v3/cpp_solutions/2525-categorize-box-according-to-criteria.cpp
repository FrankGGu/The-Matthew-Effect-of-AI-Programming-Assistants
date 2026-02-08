class Solution {
public:
    string categorizeBox(int length, int width, int height, int mass) {
        bool bulky = false;
        bool heavy = mass >= 100;

        long long volume = (long long)length * width * height;
        if (length >= 10000 || width >= 10000 || height >= 10000 || volume >= 1000000000) {
            bulky = true;
        }

        if (bulky && heavy) {
            return "Both";
        } else if (bulky) {
            return "Bulky";
        } else if (heavy) {
            return "Heavy";
        } else {
            return "Neither";
        }
    }
};