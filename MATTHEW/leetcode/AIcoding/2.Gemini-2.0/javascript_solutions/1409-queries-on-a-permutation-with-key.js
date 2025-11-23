var processQueries = function(queries, m) {
    let p = [];
    for (let i = 1; i <= m; i++) {
        p.push(i);
    }

    let result = [];
    for (let query of queries) {
        let index = p.indexOf(query);
        result.push(index);
        p.splice(index, 1);
        p.unshift(query);
    }

    return result;
};