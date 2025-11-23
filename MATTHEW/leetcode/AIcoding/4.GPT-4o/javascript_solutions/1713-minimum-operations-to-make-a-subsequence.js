var minOperations = function(target, arr) {
    const index = new Map();
    target.forEach((num, i) => index.set(num, i));

    const lis = [];
    for (const num of arr) {
        if (index.has(num)) {
            const pos = index.get(num);
            let left = 0, right = lis.length;
            while (left < right) {
                const mid = Math.floor((left + right) / 2);
                if (lis[mid] < pos) left = mid + 1;
                else right = mid;
            }
            if (left === lis.length) lis.push(pos);
            else lis[left] = pos;
        }
    }

    return target.length - lis.length;
};