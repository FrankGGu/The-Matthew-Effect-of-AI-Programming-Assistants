var mostPopularCreator = function(creators, ids, views) {
    const creatorViews = new Map();
    const creatorMaxView = new Map();

    for (let i = 0; i < creators.length; i++) {
        const creator = creators[i];
        const id = ids[i];
        const view = views[i];

        creatorViews.set(creator, (creatorViews.get(creator) || 0) + view);

        if (!creatorMaxView.has(creator) || view > creatorMaxView.get(creator).view || (view === creatorMaxView.get(creator).view && id < creatorMaxView.get(creator).id)) {
            creatorMaxView.set(creator, { id: id, view: view });
        }
    }

    let maxViews = 0;
    for (const view of creatorViews.values()) {
        maxViews = Math.max(maxViews, view);
    }

    const result = [];
    for (const [creator, view] of creatorViews) {
        if (view === maxViews) {
            result.push([creator, creatorMaxView.get(creator).id]);
        }
    }

    return result;
};