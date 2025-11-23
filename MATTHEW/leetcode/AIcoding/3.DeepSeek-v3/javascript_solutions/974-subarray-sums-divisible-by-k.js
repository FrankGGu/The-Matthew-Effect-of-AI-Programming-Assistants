var subarraysDivByK = function(nums, k) {
    let prefixMod = 0;
    let result = 0;
    const modGroups = new Array(k).fill(0);
    modGroups[0] = 1;

    for (let num of nums) {
        prefixMod = (prefixMod + num % k + k) % k;
        result += modGroups[prefixMod];
        modGroups[prefixMod]++;
    }

    return result;
};