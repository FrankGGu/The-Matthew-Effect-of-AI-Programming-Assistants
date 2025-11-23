class Solution {
public:
    string numberToWords(int num) {
        if (num == 0) return "Zero";
        return convert(num);
    }

private:
    const vector<string> belowTwenty = {
        "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine",
        "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", 
        "Seventeen", "Eighteen", "Nineteen"
    };

    const vector<string> tens = {
        "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
    };

    const vector<string> thousands = {
        "", "Thousand", "Million", "Billion"
    };

    string convert(int num) {
        if (num == 0) return "";
        if (num < 20) return belowTwenty[num] + " ";
        if (num < 100) return tens[num / 10] + " " + convert(num % 10);
        if (num < 1000) return belowTwenty[num / 100] + " Hundred " + convert(num % 100);

        for (int i = 0; i < thousands.size(); i++) {
            if (num < 1000 * pow(1000, i + 1)) {
                return convert(num / (int)pow(1000, i)) + thousands[i] + " " + convert(num % (int)pow(1000, i));
            }
        }
        return "";
    }
};