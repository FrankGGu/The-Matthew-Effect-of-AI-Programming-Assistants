var mostPopularCreator = function(creators, ids, views) {
    const totalViews = {};
    const videoCounts = {};
    const maxViewCounts = {};
    const result = [];

    for (let i = 0; i < creators.length; i++) {
        const creator = creators[i];
        const view = views[i];
        totalViews[creator] = (totalViews[creator] || 0) + view;
        videoCounts[creator] = (videoCounts[creator] || 0) + 1;

        if (!maxViewCounts[creator] || views[maxViewCounts[creator]] < view) {
            maxViewCounts[creator] = i;
        } else if (views[maxViewCounts[creator]] === view) {
            maxViewCounts[creator] = Math.min(maxViewCounts[creator], i);
        }
    }

    let maxViews = Math.max(...Object.values(totalViews));

    for (const creator in totalViews) {
        if (totalViews[creator] === maxViews) {
            result.push([creator, ids[maxViewCounts[creator]]]);
        }
    }

    return result;
};