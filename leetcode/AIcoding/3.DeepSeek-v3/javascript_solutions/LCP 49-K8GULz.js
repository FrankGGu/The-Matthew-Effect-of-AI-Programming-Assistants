var circularGame = function(nums) {
    const n = nums.length;
    const visited = new Array(n).fill(false);
    let current = 0;
    let steps = 1;

    while (true) {
        if (visited[current]) {
            return false;
        }
        visited[current] = true;
        current = (current + steps * nums[current]) % n;
        steps++;
        if (current === 0) {
            return true;
        }
    }
};