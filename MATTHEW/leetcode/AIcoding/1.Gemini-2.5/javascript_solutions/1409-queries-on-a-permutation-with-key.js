var processQueries = function(queries, m) {
    let p = [];
    for (let i = 1; i <= m; i++) {
        p.push(i);
    }

    let results = [];

    for (let i = 0; i < queries.length; i++) {
        let query = queries[i];
        let index = p.indexOf(query);
        results.push(index);

        // Remove the element from its current position
        p.splice(index, 1);
        // Add the element to the beginning
        p.unshift(query);
    }

    return results;
};