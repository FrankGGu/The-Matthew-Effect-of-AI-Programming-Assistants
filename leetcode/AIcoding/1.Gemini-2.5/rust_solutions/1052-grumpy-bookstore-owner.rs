impl Solution {
    pub fn max_satisfied(customers: Vec<i32>, grumpy: Vec<i32>, minutes: i32) -> i32 {
        let n = customers.len();
        let minutes = minutes as usize;

        let mut base_satisfied_customers = 0;
        let mut potential_saved_customers = vec![0; n];

        for i in 0..n {
            if grumpy[i] == 0 {
                base_satisfied_customers += customers[i];
            } else {
                // If the owner is grumpy, these customers can potentially be saved by the technique
                potential_saved_customers[i] = customers[i];
            }
        }

        // Calculate the sum of potential_saved_customers for the first window
        let mut current_window_sum = 0;
        for i in 0..minutes {
            current_window_sum += potential_saved_customers[i];
        }

        let mut max_saved_customers_from_technique = current_window_sum;

        // Slide the window to find the maximum number of customers that can be saved
        for i in minutes..n {
            current_window_sum -= potential_saved_customers[i - minutes]; // Remove the leftmost element
            current_window_sum += potential_saved_customers[i];           // Add the new rightmost element
            max_saved_customers_from_technique = max_saved_customers_from_technique.max(current_window_sum);
        }

        base_satisfied_customers + max_saved_customers_from_technique
    }
}