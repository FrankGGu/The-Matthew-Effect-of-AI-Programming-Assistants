var checkIfCanBreak = function(s1, s2) {
    const n = s1.length;

    const s1Arr = s1.split('').sort();
    const s2Arr = s2.split('').sort();

    const canBreak = (arr1, arr2) => {
        for (let i = 0; i < n; i++) {
            if (arr1[i] < arr2[i]) {
                return false;
            }
        }
        return true;
    };

    return canBreak(s1Arr, s2Arr) || canBreak(s2Arr, s1Arr);
};