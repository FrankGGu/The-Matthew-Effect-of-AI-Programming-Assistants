var mostPopularCreator = function(creators, ids, views) {
    const creatorData = new Map();

    for (let i = 0; i < creators.length; i++) {
        const creator = creators[i];
        const id = ids[i];
        const view = views[i];

        if (!creatorData.has(creator)) {
            creatorData.set(creator, { totalViews: 0, videos: [] });
        }
        const data = creatorData.get(creator);
        data.totalViews += view;
        data.videos.push({ id, view });
    }

    let maxTotalViews = -1;
    for (const data of creatorData.values()) {
        if (data.totalViews > maxTotalViews) {
            maxTotalViews = data.totalViews;
        }
    }

    const result = [];
    for (const [creator, data] of creatorData.entries()) {
        if (data.totalViews === maxTotalViews) {
            let mostPopularVideoId = "";
            let maxVideoViews = -1;

            for (const video of data.videos) {
                if (video.view > maxVideoViews) {
                    maxVideoViews = video.view;
                    mostPopularVideoId = video.id;
                } else if (video.view === maxVideoViews) {
                    if (mostPopularVideoId === "" || video.id < mostPopularVideoId) {
                        mostPopularVideoId = video.id;
                    }
                }
            }
            result.push([mostPopularVideoId]);
        }
    }

    return result;
};