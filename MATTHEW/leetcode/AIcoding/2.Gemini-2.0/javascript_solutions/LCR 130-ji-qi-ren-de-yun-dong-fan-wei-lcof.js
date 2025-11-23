var arrangeArticles = function(articles) {
    let count = {};
    for (let article of articles) {
        count[article] = (count[article] || 0) + 1;
    }
    let sortedCounts = Object.values(count).sort((a, b) => a - b);
    let result = 0;
    for (let i = 0; i < sortedCounts.length; i++) {
        result += sortedCounts[i] * (sortedCounts.length - 1 - i);
    }
    return result;
};