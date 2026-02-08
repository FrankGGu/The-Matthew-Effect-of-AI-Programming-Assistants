var getMinSwaps = function(num, k) {
    const getKthSmallest = (s, k) => {
        const arr = s.split('').sort();
        for (let i = 0; i < k; i++) {
            let j = i;
            while (arr[j] !== s[i]) j++;
            while (j > i) {
                let temp = arr[j];
                arr[j] = arr[j - 1];
                arr[j - 1] = temp;
                j--;
            }
        }
        return arr.join('');
    };

    const target = getKthSmallest(num, k);
    let swaps = 0;
    const numArr = num.split('');

    for (let i = 0; i < numArr.length; i++) {
        if (numArr[i] !== target[i]) {
            let j = i + 1;
            while (numArr[j] !== target[i]) j++;
            while (j > i) {
                let temp = numArr[j];
                numArr[j] = numArr[j - 1];
                numArr[j - 1] = temp;
                j--;
                swaps++;
            }
        }
    }
    return swaps;
};