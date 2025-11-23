class BankAccountSummary {
    public String[] accountSummary(String[] transactions) {
        long totalBalance = 0;
        long totalIncome = 0;
        long totalExpense = 0;

        for (String transaction : transactions) {
            String[] parts = transaction.split(" ");
            long amount = Long.parseLong(parts[1]);
            if (parts[0].equals("Income")) {
                totalIncome += amount;
            } else if (parts[0].equals("Expense")) {
                totalExpense += amount;
            }
        }
        totalBalance = totalIncome - totalExpense;

        return new String[]{
            "Total Balance: " + totalBalance,
            "Total Income: " + totalIncome,
            "Total Expense: " + totalExpense
        };
    }
}