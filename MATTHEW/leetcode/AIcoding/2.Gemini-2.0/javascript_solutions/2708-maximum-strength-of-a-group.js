var maxStrength = function(nums) {
    if (nums.length === 0) {
        return 0;
    }

    nums.sort((a, b) => a - b);

    let product = 1;
    let negCount = 0;
    let firstNegIndex = -1;
    let hasZero = false;

    for (let i = 0; i < nums.length; i++) {
        if (nums[i] < 0) {
            negCount++;
            if (firstNegIndex === -1) {
                firstNegIndex = i;
            }
        } else if (nums[i] === 0) {
            hasZero = true;
        }
    }

    if (nums.length === 1) {
        return nums[0];
    }

    if (negCount % 2 === 0) {
        let allZero = true;
        for(let i = 0; i < nums.length; i++){
            if(nums[i] !== 0){
                allZero = false;
                break;
            }
        }
        if(allZero){
            return 0;
        }

        for (let i = 0; i < nums.length; i++) {
            if (nums[i] !== 0) {
                product *= nums[i];
            }
        }
        return product;
    } else {
        if (nums.length === 1 && nums[0] <= 0) return nums[0];
        if (hasZero && nums.length === negCount + 1) return 0;
        if (nums.length === negCount && hasZero) return 0;

        if (negCount === 1 && hasZero && nums.length > 1) return 0;
         if (negCount === nums.length && hasZero) return 0;

        if(negCount === nums.length && !hasZero){
             nums.pop()
             for (let i = 0; i < nums.length; i++) {
            if (nums[i] !== 0) {
                product *= nums[i];
            }
        }
        return product;
        }

        let removed = false;
        for (let i = 0; i < nums.length; i++) {
                if (nums[i] < 0 && !removed){
                        if(i === firstNegIndex){
                                removed = true;
                        } else {
                                product *= nums[i];
                        }
                } else if (nums[i] !== 0){
                        product *= nums[i];
                }
        }
        return product;
    }
};