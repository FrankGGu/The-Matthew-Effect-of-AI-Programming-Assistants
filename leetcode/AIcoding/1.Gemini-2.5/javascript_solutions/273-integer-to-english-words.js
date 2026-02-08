const lessThanTwenty = ["One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"];
const tens = ["Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"];
const thousands = ["", "Thousand", "Million", "Billion"];

function numberToWords(num) {
    if (num === 0) {
        return "Zero";
    }

    let result = [];
    let i = 0;

    function convertHundreds(n) {
        let parts = [];
        if (n >= 100) {
            parts.push(lessThanTwenty[Math.floor(n / 100) - 1]);
            parts.push("Hundred");
            n %= 100;
        }
        if (n > 0) {
            if (n < 20) {
                parts.push(lessThanTwenty[n - 1]);
            } else {
                parts.push(tens[Math.floor(n / 10) - 1]);
                if (n % 10 > 0) {
                    parts.push(lessThanTwenty[n % 10 - 1]);
                }
            }
        }
        return parts.join(" ");
    }

    while (num > 0) {
        let currentBlock = num % 1000;
        if (currentBlock !== 0) {
            let blockWords = convertHundreds(currentBlock);
            if (i > 0) {
                result.unshift(thousands[i]);
            }
            result.unshift(blockWords);
        }
        num = Math.floor(num / 1000);
        i++;
    }

    return result.join(" ");
}