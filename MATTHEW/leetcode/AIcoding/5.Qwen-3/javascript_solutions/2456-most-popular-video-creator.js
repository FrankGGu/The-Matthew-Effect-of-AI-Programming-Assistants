function mostPopularVideoCreator(creators, videos) {
    const creatorMap = {};
    let maxViews = 0;

    for (let i = 0; i < creators.length; i++) {
        const creator = creators[i];
        const video = videos[i];

        if (!creatorMap[creator]) {
            creatorMap[creator] = { totalViews: 0, mostPopularVideo: '', maxView: 0 };
        }

        creatorMap[creator].totalViews += 1;
        if (video.length > creatorMap[creator].maxView) {
            creatorMap[creator].mostPopularVideo = video;
            creatorMap[creator].maxView = video.length;
        }
    }

    const result = [];
    for (const creator in creatorMap) {
        if (creatorMap[creator].totalViews > maxViews) {
            maxViews = creatorMap[creator].totalViews;
        }
    }

    for (const creator in creatorMap) {
        if (creatorMap[creator].totalViews === maxViews) {
            result.push([creator, creatorMap[creator].mostPopularVideo]);
        }
    }

    return result;
}