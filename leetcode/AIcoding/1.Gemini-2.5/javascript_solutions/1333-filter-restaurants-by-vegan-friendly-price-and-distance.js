var filterRestaurants = function(restaurants, veganFriendly, maxPrice, maxDistance) {
    return restaurants
        .filter(restaurant => {
            const [, , rVeganFriendly, rPrice, rDistance] = restaurant;
            return (veganFriendly === 0 || rVeganFriendly === 1) &&
                   rPrice <= maxPrice &&
                   rDistance <= maxDistance;
        })
        .sort((a, b) => {
            const [aId, aRating] = a;
            const [bId, bRating] = b;

            if (aRating !== bRating) {
                return bRating - aRating;
            }
            return bId - aId;
        })
        .map(restaurant => restaurant[0]);
};