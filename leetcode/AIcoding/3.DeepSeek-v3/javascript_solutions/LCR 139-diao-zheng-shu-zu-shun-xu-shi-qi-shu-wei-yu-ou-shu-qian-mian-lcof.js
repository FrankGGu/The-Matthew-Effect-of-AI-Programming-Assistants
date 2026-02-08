var trainingPlan = function(actions) {
    let left = 0;
    let right = actions.length - 1;
    while (left < right) {
        while (left < right && actions[left] % 2 === 1) {
            left++;
        }
        while (left < right && actions[right] % 2 === 0) {
            right--;
        }
        if (left < right) {
            [actions[left], actions[right]] = [actions[right], actions[left]];
            left++;
            right--;
        }
    }
    return actions;
};