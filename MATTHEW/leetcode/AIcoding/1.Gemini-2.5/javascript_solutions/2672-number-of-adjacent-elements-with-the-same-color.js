var colorTheArray = function(n, queries) {
    let colors = new Array(n).fill(0);
    let currentAdjacentPairs = 0;
    let ans = [];

    for (let i = 0; i < queries.length; i++) {
        let index = queries[i][0];
        let newColor = queries[i][1];

        let oldColor = colors[index];

        if (oldColor !== newColor) {
            if (index > 0 && colors[index - 1] === oldColor && oldColor !== 0) {
                currentAdjacentPairs--;
            }
            if (index < n - 1 && colors[index + 1] === oldColor && oldColor !== 0) {
                currentAdjacentPairs--;
            }

            colors[index] = newColor;

            if (index > 0 && colors[index - 1] === newColor) {
                currentAdjacentPairs++;
            }
            if (index < n - 1 && colors[index + 1] === newColor) {
                currentAdjacentPairs++;
            }
        }

        ans.push(currentAdjacentPairs);
    }

    return ans;
};