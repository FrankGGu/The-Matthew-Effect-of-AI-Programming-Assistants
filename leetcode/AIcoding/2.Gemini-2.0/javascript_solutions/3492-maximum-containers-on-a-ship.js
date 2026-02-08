var maximumContainers = function(containers, space) {
    containers.sort((a, b) => a - b);
    let count = 0;
    let left = 0;
    let right = containers.length - 1;

    while (left <= right) {
        if (containers[left] + containers[right] <= space) {
            count++;
            left++;
            right--;
        } else {
            right--;
        }
    }

    return count;
};