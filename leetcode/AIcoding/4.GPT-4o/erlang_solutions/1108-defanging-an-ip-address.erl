defmodule Solution do
    @spec defang_i_paddr(s :: String.t()) :: String.t()
    def defang_i_paddr(s) do
        String.replace(s, ".", "[.]")
    end
end