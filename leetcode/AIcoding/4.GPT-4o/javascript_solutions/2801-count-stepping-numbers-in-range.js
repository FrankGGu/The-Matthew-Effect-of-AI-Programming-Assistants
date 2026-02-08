var countSteppingNumbers = function(low, high) {
    const result = [];

    const bfs = (start) => {
        const queue = [start];
        while (queue.length > 0) {
            const num = queue.shift();
            if (num >= low && num <= high) {
                result.push(num);
            }
            if (num > high) continue;
            const lastDigit = num % 10;
            if (lastDigit > 0) {
                queue.push(num * 10 + (lastDigit - 1));
            }
            if (lastDigit < 9) {
                queue.push(num * 10 + (lastDigit + 1));
            }
        }
    };

    for (let i = 0; i < 10; i++) {
        bfs(i);
    }

    return result.length;
};