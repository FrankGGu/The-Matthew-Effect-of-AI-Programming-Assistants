var catMouseGame = function(graph) {
    const n = graph.length;
    const DRAW = 0, MOUSE = 1, CAT = 2;
    const color = Array.from({length: n}, () => Array.from({length: n}, () => Array(2).fill(0)));
    const degree = Array.from({length: n}, () => Array.from({length: n}, () => Array(2).fill(0)));

    for (let m = 0; m < n; ++m) {
        for (let c = 0; c < n; ++c) {
            degree[m][c][0] = graph[m].length;
            degree[m][c][1] = graph[c].length;
            if (graph[c].includes(0)) {
                degree[m][c][1]--;
            }
        }
    }

    const queue = [];
    for (let i = 0; i < n; ++i) {
        for (let t = 0; t < 2; ++t) {
            color[0][i][t] = MOUSE;
            queue.push([0, i, t, MOUSE]);
            if (i > 0) {
                color[i][i][t] = CAT;
                queue.push([i, i, t, CAT]);
            }
        }
    }

    while (queue.length) {
        const [i, j, t, c] = queue.shift();
        for (const [prevI, prevJ, prevT] of parents(graph, i, j, t)) {
            if (color[prevI][prevJ][prevT] === DRAW) {
                if ((prevT === 0 && c === MOUSE) || (prevT === 1 && c === CAT)) {
                    color[prevI][prevJ][prevT] = c;
                    queue.push([prevI, prevJ, prevT, c]);
                } else {
                    degree[prevI][prevJ][prevT]--;
                    if (degree[prevI][prevJ][prevT] === 0) {
                        color[prevI][prevJ][prevT] = prevT === 0 ? CAT : MOUSE;
                        queue.push([prevI, prevJ, prevT, color[prevI][prevJ][prevT]]);
                    }
                }
            }
        }
    }

    return color[1][2][0];
};

function parents(graph, m, c, t) {
    const res = [];
    if (t === 1) {
        for (const m2 of graph[m]) {
            res.push([m2, c, 0]);
        }
    } else {
        for (const c2 of graph[c]) {
            if (c2 !== 0) {
                res.push([m, c2, 1]);
            }
        }
    }
    return res;
}