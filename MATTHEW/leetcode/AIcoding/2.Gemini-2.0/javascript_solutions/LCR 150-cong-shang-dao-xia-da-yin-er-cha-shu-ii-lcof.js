var lightDistribution = function(root) {
    const dfs = (node) => {
        if (!node) {
            return [0, 0];
        }

        const [leftNoLight, leftLight] = dfs(node.left);
        const [rightNoLight, rightLight] = dfs(node.right);

        const noLight = leftLight + rightLight;
        const light = Math.min(leftLight + rightLight, leftLight + rightNoLight, leftNoLight + rightLight, leftNoLight + rightNoLight) + 1;

        return [noLight, light];
    };

    const [noLight, light] = dfs(root);
    return [noLight, light];
};