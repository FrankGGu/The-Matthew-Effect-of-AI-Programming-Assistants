var numberToWords = function(num) {
    if (num === 0) return "Zero";

    const lessThan20 = ["", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
    const tens = ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
    const thousands = ["", "Thousand", "Million", "Billion"];

    function helper(n) {
        if (n < 20) {
            return lessThan20[n];
        } else if (n < 100) {
            return tens[Math.floor(n / 10)] + (n % 10 === 0 ? "" : " " + lessThan20[n % 10]);
        } else {
            return lessThan20[Math.floor(n / 100)] + " Hundred" + (n % 100 === 0 ? "" : " " + helper(n % 100));
        }
    }

    let result = "";
    let i = 0;
    while (num > 0) {
        if (num % 1000 !== 0) {
            result = helper(num % 1000) + " " + thousands[i] + " " + result;
        }
        num = Math.floor(num / 1000);
        i++;
    }

    return result.trim();
};