function minTimeToCutTrees(trees, target) {
    let left = 1, right = Math.max(...trees);

    const canCutAll = (time) => {
        let count = 0;
        for (let height of trees) {
            count += Math.floor(time / height);
        }
        return count >= target;
    };

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        if (canCutAll(mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}