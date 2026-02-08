var categoryRecommendations = function(reviews, users) {
    const userToCategories = {};
    const categoryPairs = {};

    // Populate userToCategories map
    for (const review of reviews) {
        const userId = review[0];
        const category = review[1];
        if (!userToCategories[userId]) {
            userToCategories[userId] = new Set();
        }
        userToCategories[userId].add(category);
    }

    // Generate all possible pairs for each user
    for (const userId in userToCategories) {
        const categories = Array.from(userToCategories[userId]);
        for (let i = 0; i < categories.length; i++) {
            for (let j = i + 1; j < categories.length; j++) {
                const cat1 = categories[i];
                const cat2 = categories[j];
                const key = cat1 < cat2 ? `${cat1},${cat2}` : `${cat2},${cat1}`;
                categoryPairs[key] = (categoryPairs[key] || 0) + 1;
            }
        }
    }

    // Filter pairs that have at least one user in common
    const result = [];
    for (const key in categoryPairs) {
        const [cat1, cat2] = key.split(',');
        result.push([cat1, cat2, categoryPairs[key]]);
    }

    // Sort the result
    result.sort((a, b) => {
        if (a[2] !== b[2]) {
            return b[2] - a[2];
        } else if (a[0] !== b[0]) {
            return a[0].localeCompare(b[0]);
        } else {
            return a[1].localeCompare(b[1]);
        }
    });

    return result;
};