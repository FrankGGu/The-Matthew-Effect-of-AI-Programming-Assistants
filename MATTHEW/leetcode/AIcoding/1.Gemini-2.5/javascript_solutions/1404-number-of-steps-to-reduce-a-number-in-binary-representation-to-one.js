var numSteps = function(s) {
    let arr = s.split('');
    let steps = 0;

    while (arr.length > 1) {
        steps++;
        if (arr[arr.length - 1] === '0') {
            // Even number: divide by 2 (remove trailing '0')
            arr.pop();
        } else {
            // Odd number: add 1
            let i = arr.length - 1;
            while (i >= 0 && arr[i] === '1') {
                arr[i] = '0';
                i--;
            }
            if (i < 0) {
                // All ones (e.g., "111" + 1 -> "1000")
                arr.unshift('1');
            } else {
                // Found a '0' to flip (e.g., "101" + 1 -> "110")
                arr[i] = '1';
            }
        }
    }

    return steps;
};