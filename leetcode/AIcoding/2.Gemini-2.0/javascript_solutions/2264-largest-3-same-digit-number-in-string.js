var largestGoodInteger = function(num) {
    let largest = "";
    for (let i = 0; i <= num.length - 3; i++) {
        if (num[i] === num[i + 1] && num[i] === num[i + 2]) {
            let current = num[i] + num[i + 1] + num[i + 2];
            if (largest === "" || current > largest) {
                largest = current;
            }
        }
    }
    return largest;
};