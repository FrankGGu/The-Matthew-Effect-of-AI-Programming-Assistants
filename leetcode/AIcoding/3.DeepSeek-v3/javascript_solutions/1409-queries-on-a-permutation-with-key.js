var processQueries = function(queries, m) {
    let P = Array.from({length: m}, (_, i) => i + 1);
    let result = [];

    for (let query of queries) {
        let index = P.indexOf(query);
        result.push(index);
        P.splice(index, 1);
        P.unshift(query);
    }

    return result;
};