var distributeElements = function(nums) {
    const n = nums.length;
    const arr1 = [];
    const arr2 = [];
    const result = new Array(n);

    let i = 0;
    let j = 0;
    let k = 0;

    for (const num of nums) {
        if (arr1.length <= arr2.length) {
            arr1.push(num);
            result[i++] = 1;
        } else {
            arr2.push(num);
            result[i++] = 2;
        }
    }

    i = 0;
    j = 0;
    k = 0;
    const ans = new Array(n);

    for (let l = 0; l < n; l++) {
        if (result[l] === 1) {
            ans[l] = arr1[i++];
        } else {
            ans[l] = arr2[j++];
        }
    }
    return ans;
};