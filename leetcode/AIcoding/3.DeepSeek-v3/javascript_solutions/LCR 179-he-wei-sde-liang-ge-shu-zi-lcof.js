var twoSum = function(numbers, target) {
    let left = 0;
    let right = numbers.length - 1;
    while (left < right) {
        const sum = numbers[left] + numbers[right];
        if (sum === target) {
            return [numbers[left], numbers[right]];
        } else if (sum < target) {
            left++;
        } else {
            right--;
        }
    }
    return [];
};