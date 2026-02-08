var getMinSwaps = function(num, k) {
    const getNextPermutation = (arr) => {
        let i = arr.length - 2;
        while (i >= 0 && arr[i] >= arr[i + 1]) {
            i--;
        }
        if (i < 0) {
            return false;
        }
        let j = arr.length - 1;
        while (arr[j] <= arr[i]) {
            j--;
        }
        [arr[i], arr[j]] = [arr[j], arr[i]];
        let l = i + 1;
        let r = arr.length - 1;
        while (l < r) {
            [arr[l], arr[r]] = [arr[r], arr[l]];
            l++;
            r--;
        }
        return true;
    };

    let arr = num.split("").map(Number);
    let originalArr = [...arr];

    for (let i = 0; i < k; i++) {
        getNextPermutation(arr);
    }

    let targetArr = arr;
    arr = [...originalArr];

    let swaps = 0;
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] !== targetArr[i]) {
            let j = i + 1;
            while (arr[j] !== targetArr[i]) {
                j++;
            }
            for (let l = j; l > i; l--) {
                [arr[l], arr[l - 1]] = [arr[l - 1], arr[l]];
                swaps++;
            }
        }
    }
    return swaps;
};