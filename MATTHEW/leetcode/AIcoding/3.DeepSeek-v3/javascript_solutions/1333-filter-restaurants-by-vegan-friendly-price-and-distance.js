var filterRestaurants = function(restaurants, veganFriendly, maxPrice, maxDistance) {
    return restaurants
        .filter(restaurant => {
            const [id, rating, vegan, price, distance] = restaurant;
            return (!veganFriendly || vegan) && price <= maxPrice && distance <= maxDistance;
        })
        .sort((a, b) => {
            if (a[1] !== b[1]) {
                return b[1] - a[1];
            } else {
                return b[0] - a[0];
            }
        })
        .map(restaurant => restaurant[0]);
};