function totalFruit(nums) {
    let left = 0;
    let maxFruits = 0;
    const basket = {};

    for (let right = 0; right < nums.length; right++) {
        const fruit = nums[right];
        basket[fruit] = (basket[fruit] || 0) + 1;

        while (Object.keys(basket).length > 2) {
            const leftFruit = nums[left];
            basket[leftFruit]--;
            if (basket[leftFruit] === 0) {
                delete basket[leftFruit];
            }
            left++;
        }

        maxFruits = Math.max(maxFruits, right - left + 1);
    }

    return maxFruits;
}