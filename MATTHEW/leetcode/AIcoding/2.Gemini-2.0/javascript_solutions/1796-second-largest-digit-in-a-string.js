var secondHighest = function(s) {
    let largest = -1;
    let secondLargest = -1;

    for (let char of s) {
        if (!isNaN(parseInt(char))) {
            let num = parseInt(char);
            if (num > largest) {
                secondLargest = largest;
                largest = num;
            } else if (num < largest && num > secondLargest) {
                secondLargest = num;
            }
        }
    }

    return secondLargest;
};