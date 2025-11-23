function digitsToWords(digits) {
    const ones = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"];
    const teens = ["Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
    const tens = ["", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
    const thousands = ["", "Thousand", "Million", "Billion"];

    function helper(num) {
        if (num === 0) return "";
        if (num < 10) return ones[num];
        if (num < 20) return teens[num - 10];
        if (num < 100) {
            return tens[Math.floor(num / 10)] + (num % 10 ? " " + ones[num % 10] : "");
        }
        if (num < 1000) {
            return ones[Math.floor(num / 100)] + " Hundred" + (num % 100 ? " " + helper(num % 100) : "");
        }
        for (let i = 3; i >= 1; i--) {
            const unit = Math.pow(1000, i);
            if (num >= unit) {
                return helper(Math.floor(num / unit)) + " " + thousands[i] + (num % unit ? " " + helper(num % unit) : "");
            }
        }
        return "";
    }

    let result = "";
    let num = parseInt(digits);
    if (num === 0) return "Zero";
    for (let i = 3; i >= 0; i--) {
        const chunk = Math.floor(num / Math.pow(1000, i));
        if (chunk > 0) {
            result += helper(chunk) + (i > 0 ? " " + thousands[i] : "") + " ";
        }
        num %= Math.pow(1000, i);
    }
    return result.trim();
}