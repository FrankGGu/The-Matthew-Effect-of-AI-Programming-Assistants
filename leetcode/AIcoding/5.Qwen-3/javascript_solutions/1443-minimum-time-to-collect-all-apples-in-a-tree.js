function minTimeToCollectAllApples(root) {
    const dfs = (node) => {
        if (!node) return [0, false];
        const [leftTime, leftHasApple] = dfs(node.left);
        const [rightTime, rightHasApple] = dfs(node.right);
        let time = 0;
        let hasApple = node.val === 1;
        if (leftHasApple || rightHasApple) {
            time += leftTime + rightTime + 2;
            hasApple = true;
        }
        return [time, hasApple];
    };
    return dfs(root)[0];
}