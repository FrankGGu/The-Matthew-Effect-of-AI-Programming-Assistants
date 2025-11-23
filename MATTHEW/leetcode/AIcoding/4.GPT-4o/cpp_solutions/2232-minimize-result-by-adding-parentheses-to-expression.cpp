class Solution {
public:
    string minimizeResult(string expression) {
        int plusPos = expression.find('+');
        string a = expression.substr(0, plusPos);
        string b = expression.substr(plusPos + 1);

        int minValue = INT_MAX;
        string result = "";

        for (int i = 0; i <= a.size(); ++i) {
            for (int j = 1; j <= b.size(); ++j) {
                string left = a.substr(0, i);
                string right = a.substr(i);
                string leftB = b.substr(0, j);
                string rightB = b.substr(j);

                int leftNum = left.empty() ? 1 : stoi(left);
                int rightNum = right.empty() ? 1 : stoi(right);
                int leftBNum = leftB.empty() ? 0 : stoi(leftB);
                int rightBNum = rightB.empty() ? 0 : stoi(rightB);

                int currentValue = leftNum * (leftBNum + rightNum) + rightBNum;

                if (currentValue < minValue) {
                    minValue = currentValue;
                    result = left + "(" + leftB + rightNum + ")" + rightB;
                }
            }
        }

        return result;
    }
};