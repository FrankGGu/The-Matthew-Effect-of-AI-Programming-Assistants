var filterRestaurants = function(restaurants, veganFriendly, maxPrice, maxDistance) {
    return restaurants
        .filter(restaurant => 
            (veganFriendly === 0 || restaurant[2] === 1) &&
            restaurant[3] <= maxPrice &&
            restaurant[4] <= maxDistance
        )
        .sort((a, b) => b[1] - a[1] || b[0] - a[0]);
};