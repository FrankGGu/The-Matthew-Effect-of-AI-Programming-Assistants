var minimumFuelCost = function(root, seats) {
    let fuel = 0;

    function dfs(node) {
        if (!node) return 0;

        let people = 1;
        if (node.left) {
            people += dfs(node.left);
        }
        if (node.right) {
            people += dfs(node.right);
        }

        if (node !== root) {
            fuel += Math.ceil(people / seats);
        }

        return people;
    }

    dfs(root);
    return fuel;
};