var mostPopularCreator = function(creators, ids, views) {
    const creatorStats = {};
    let maxTotal = -Infinity;

    for (let i = 0; i < creators.length; i++) {
        const creator = creators[i];
        const id = ids[i];
        const view = views[i];

        if (!creatorStats[creator]) {
            creatorStats[creator] = {
                total: 0,
                maxView: -1,
                maxId: ''
            };
        }

        const stats = creatorStats[creator];
        stats.total += view;

        if (view > stats.maxView || (view === stats.maxView && id < stats.maxId)) {
            stats.maxView = view;
            stats.maxId = id;
        }

        if (stats.total > maxTotal) {
            maxTotal = stats.total;
        }
    }

    const result = [];
    for (const creator in creatorStats) {
        const stats = creatorStats[creator];
        if (stats.total === maxTotal) {
            result.push([creator, stats.maxId]);
        }
    }

    return result;
};