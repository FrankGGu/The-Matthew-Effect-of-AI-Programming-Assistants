var magicTower = function(nums) {
    let sum = 0;
    for (let num of nums) {
        sum += num;
    }
    if (sum < 0) {
        return -1;
    }

    let currentHealth = 1;
    let heap = [];
    let loss = 0;
    let moves = 0;

    for (let num of nums) {
        if (num < 0) {
            heap.push(num);
            heap.sort((a, b) => a - b);
        }
        currentHealth += num;

        while (currentHealth <= 0) {
            if (heap.length === 0) return -1;
            let smallestLoss = heap.shift();
            currentHealth -= smallestLoss;
            loss += smallestLoss;
            moves++;
        }
    }

    return moves;
};