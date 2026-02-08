class Solution {
public:
    string categorizeBox(int length, int width, int height, int weight) {
        bool isBulky = length >= 10000 || width >= 10000 || height >= 10000 || (length * width * height >= 1000000000);
        bool isHeavy = weight >= 100;

        if (isBulky) {
            return isHeavy ? "Both" : "Bulky";
        } else {
            return isHeavy ? "Heavy" : "Light";
        }
    }
};