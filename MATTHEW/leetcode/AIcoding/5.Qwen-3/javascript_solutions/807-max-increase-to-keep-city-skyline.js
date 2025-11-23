var maxIncreaseKeepingSkyline = function(grid) {
    var rowMax = new Array(grid.length);
    var colMax = new Array(grid[0].length);

    for (var i = 0; i < grid.length; i++) {
        rowMax[i] = Math.max(...grid[i]);
    }

    for (var j = 0; j < grid[0].length; j++) {
        var max = 0;
        for (var i = 0; i < grid.length; i++) {
            if (grid[i][j] > max) {
                max = grid[i][j];
            }
        }
        colMax[j] = max;
    }

    var total = 0;
    for (var i = 0; i < grid.length; i++) {
        for (var j = 0; j < grid[0].length; j++) {
            total += Math.min(rowMax[i], colMax[j]) - grid[i][j];
        }
    }

    return total;
};