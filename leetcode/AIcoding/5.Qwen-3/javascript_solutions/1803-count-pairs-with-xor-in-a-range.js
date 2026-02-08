function countPairs(nums, low, high) {
    function countLessThanXOR(x) {
        let count = 0;
        const trie = {};
        for (const num of nums) {
            let node = trie;
            for (let i = 30; i >= 0; i--) {
                const bit = (num >> i) & 1;
                if (!node[bit]) node[bit] = {};
                node = node[bit];
            }
            node['isEnd'] = true;
        }

        let result = 0;
        for (const num of nums) {
            let node = trie;
            let currentXOR = 0;
            for (let i = 30; i >= 0; i--) {
                const bit = (num >> i) & 1;
                const targetBit = (x >> i) & 1;
                if (targetBit === 1) {
                    if (node[1 - bit]) {
                        let temp = node[1 - bit];
                        let tempCount = 0;
                        const stack = [temp];
                        while (stack.length) {
                            const curr = stack.pop();
                            if (curr['isEnd']) tempCount++;
                            for (const key in curr) {
                                if (key !== 'isEnd') stack.push(curr[key]);
                            }
                        }
                        result += tempCount;
                    }
                } else {
                    if (node[bit]) {
                        let temp = node[bit];
                        let tempCount = 0;
                        const stack = [temp];
                        while (stack.length) {
                            const curr = stack.pop();
                            if (curr['isEnd']) tempCount++;
                            for (const key in curr) {
                                if (key !== 'isEnd') stack.push(curr[key]);
                            }
                        }
                        result += tempCount;
                    }
                }
                if (!node[bit]) break;
                node = node[bit];
            }
        }
        return result;
    }

    return countLessThanXOR(high + 1) - countLessThanXOR(low);
}